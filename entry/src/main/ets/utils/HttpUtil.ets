import http from '@ohos.net.http'

export type PostData = Record<string, string | number | boolean | null>

export default class HttpUtil {
  private static errorMessage(e: string | number | boolean | object | null | undefined): string {
    if (e instanceof Error) {
      return e.message
    }
    if (typeof e === 'string') {
      return e
    }
    if (typeof e === 'number' || typeof e === 'boolean') {
      return String(e)
    }
    if (typeof e === 'object' && e !== null) {
      const rec: Record<string, string | number | boolean | null | object> = e as Record<
        string,
        string | number | boolean | null | object
      >
      const msgVal = rec['message']
      const codeVal = rec['code']

      const parts: string[] = []
      if (typeof codeVal === 'string' || typeof codeVal === 'number') {
        parts.push(`code=${String(codeVal)}`)
      }
      if (typeof msgVal === 'string') {
        parts.push(msgVal)
      }
      if (parts.length > 0) {
        return parts.join(', ')
      }

      try {
        return JSON.stringify(e)
      } catch (_) {
        return 'object error'
      }
    }
    return 'unknown error'
  }

  static async post<T>(url: string, data: PostData): Promise<T> {
    const client: http.HttpRequest = http.createHttp()

    try {
      const options: http.HttpRequestOptions = {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: JSON.stringify(data),
        expectDataType: http.HttpDataType.STRING
      }

      const resp: http.HttpResponse = await new Promise<http.HttpResponse>((resolve, reject) => {
        client.request(url, options, (err: Error | null, result: http.HttpResponse) => {
          if (err) {
            reject(err)
            return
          }
          resolve(result)
        })
      })

      const code: number = resp.responseCode
      const raw: string = typeof resp.result === 'string' ? resp.result : String(resp.result ?? '')

      if (code < 200 || code >= 300) {
        throw new Error(`HTTP ${code}: ${raw}`)
      }

      return JSON.parse(raw) as T
    } catch (e) {
      const msg: string = HttpUtil.errorMessage(e)
      throw new Error(`POST ${url} failed: ${msg}`)
    } finally {
      client.destroy()
    }
  }
}
