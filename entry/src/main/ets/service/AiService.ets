import HttpUtil, { type PostData } from '../utils/HttpUtil'

export interface AiResult {
  summary: string
  mood: string
}

type JsonValue = string | number | boolean | null | object
type JsonRecord = Record<string, JsonValue>

interface AiRequest extends PostData {
  content: string
}

const AI_URL: string = 'http://192.168.43.1:8000/api/ai/summary'

export default class AiService {
  private async request(content: string): Promise<AiResult> {
    const req: AiRequest = { content: content }
    const raw: JsonRecord = await HttpUtil.post<JsonRecord>(AI_URL, req)

    let summaryVal: JsonValue = raw['summary']
    let moodVal: JsonValue = raw['mood']

    const dataVal: JsonValue = raw['data']
    if ((typeof summaryVal !== 'string' || typeof moodVal !== 'string') && typeof dataVal === 'object' && dataVal !== null) {
      const dataRec: JsonRecord = dataVal as JsonRecord
      summaryVal = dataRec['summary']
      moodVal = dataRec['mood']
    }

    const summary: string = typeof summaryVal === 'string' ? summaryVal : ''
    const mood: string = typeof moodVal === 'string' ? moodVal : ''

    const res: AiResult = { summary: summary, mood: mood }
    return res
  }

  async generateSummary(content: string): Promise<string> {
    const resp: AiResult = await this.request(content)
    return resp.summary
  }

  async analyzeMood(content: string): Promise<string> {
    const resp: AiResult = await this.request(content)
    return resp.mood
  }

  async generate(content: string): Promise<AiResult> {
    return await this.request(content)
  }
}
