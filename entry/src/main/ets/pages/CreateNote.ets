import router from '@ohos.router'
import type { Note } from '../model/NoteModel'
import AiService, { type AiResult } from '../service/AiService'
import StorageService from '../service/StorageService'

type MoodType = 'positive' | 'negative'

@Entry
@Component
struct CreateNote {
  @State private title: string = ''
  @State private content: string = ''
  @State private mood: MoodType = 'positive'
  @State private isAiLoading: boolean = false
  @State private aiError: string = ''

  private storage: StorageService | null = null
  private ai: AiService | null = null

  private getStorage(): StorageService {
    if (this.storage) {
      return this.storage
    }
    this.storage = new StorageService(getContext(this))
    return this.storage
  }

  private getAi(): AiService {
    if (this.ai) {
      return this.ai
    }
    this.ai = new AiService()
    return this.ai
  }

  private goBack(): void {
    router.back()
  }

  private canSave(): boolean {
    return this.title.trim().length > 0 && this.content.trim().length > 0
  }

  private canAiGenerate(): boolean {
    return !this.isAiLoading && this.content.trim().length > 0
  }

  private moodText(mood: MoodType): string {
    return mood === 'positive' ? '积极😊' : '消极😔'
  }

  private moodBg(mood: MoodType): string {
    return mood === 'positive' ? '#EAF9F0' : '#FDECEC'
  }

  private moodFg(mood: MoodType): string {
    return mood === 'positive' ? '#117A37' : '#B42318'
  }

  private formatTime(date: Date): string {
    const y: number = date.getFullYear()
    const m: number = date.getMonth() + 1
    const d: number = date.getDate()
    const hh: number = date.getHours()
    const mm: number = date.getMinutes()

    const mm2: string = mm < 10 ? `0${mm}` : `${mm}`
    const hh2: string = hh < 10 ? `0${hh}` : `${hh}`
    const m2: string = m < 10 ? `0${m}` : `${m}`
    const d2: string = d < 10 ? `0${d}` : `${d}`

    return `${y}-${m2}-${d2} ${hh2}:${mm2}`
  }

  private safeTrim(v: string | null | undefined): string {
    return typeof v === 'string' ? v.trim() : ''
  }

  private normalizeMood(raw: string | null | undefined): MoodType {
    const v: string = this.safeTrim(raw).toLowerCase()
    if (v === 'negative' || v === 'neg' || v === 'bad' || v === '消极') {
      return 'negative'
    }
    return 'positive'
  }

  private buildTitleFromSummary(summary: string | null | undefined): string {
    const s: string = this.safeTrim(summary)
    if (s.length === 0) {
      return ''
    }
    return s.length > 20 ? `${s.slice(0, 20)}…` : s
  }

  private async onAIGenerate(): Promise<void> {
    if (!this.canAiGenerate()) {
      return
    }

    this.isAiLoading = true
    this.aiError = ''
    try {
      const ai: AiService = this.getAi()
      const res: AiResult = await ai.generate(this.content.trim())

      const nextTitle: string = this.buildTitleFromSummary(res.summary)
      if (nextTitle.length > 0) {
        this.title = nextTitle
      }
      this.mood = this.normalizeMood(res.mood)
    } catch (e) {
      const msg: string = e instanceof Error ? e.message : 'AI 请求失败'
      this.aiError = msg
    } finally {
      this.isAiLoading = false
    }
  }

  private async onSave(): Promise<void> {
    if (!this.canSave()) {
      return
    }

    const now: Date = new Date()
    const id: string = `${now.getTime()}_${Math.floor(Math.random() * 100000)}`
    const time: string = this.formatTime(now)

    const note: Note = {
      id: id,
      title: this.title.trim(),
      content: this.content.trim(),
      time: time,
      mood: this.mood
    }

    const storage: StorageService = this.getStorage()
    const list: Note[] = await storage.getNotes()
    const next: Note[] = list.slice()
    next.push(note)
    await storage.saveNotes(next)

    router.back()
  }

  build() {
    Column() {
      Row() {
        Text('新建便签')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .layoutWeight(1)

        Button() {
          Text('取消')
            .fontSize(14)
            .fontColor('#6B7280')
        }
        .backgroundColor(Color.Transparent)
        .padding({ left: 10, right: 10, top: 8, bottom: 8 })
        .onClick(() => this.goBack())
      }
      .padding({ left: 20, right: 20, top: 18, bottom: 12 })

      Column() {
        Row() {
          Text('标题')
            .fontSize(12)
            .fontColor('#6B7280')
            .layoutWeight(1)

          Row() {
            Text(this.moodText(this.mood))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.moodFg(this.mood))
          }
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor(this.moodBg(this.mood))
          .borderRadius(999)
        }
        .margin({ bottom: 8 })

        TextInput({ text: this.title, placeholder: '请输入标题' })
          .fontSize(15)
          .fontColor('#111827')
          .placeholderColor('#9CA3AF')
          .height(46)
          .padding({ left: 14, right: 14 })
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .onChange((v: string) => {
            this.title = v ?? ''
          })
      }
      .padding({ left: 20, right: 20, top: 10 })

      Column() {
        Text('内容')
          .fontSize(12)
          .fontColor('#6B7280')
          .margin({ bottom: 8, top: 14 })

        TextArea({ text: this.content, placeholder: '写点什么…' })
          .fontSize(15)
          .fontColor('#111827')
          .placeholderColor('#9CA3AF')
          .padding({ left: 14, right: 14, top: 12, bottom: 12 })
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .height(220)
          .onChange((v: string) => {
            this.content = v ?? ''
          })
      }
      .padding({ left: 20, right: 20 })

      Row() {
        Button() {
          Row() {
            Text(this.isAiLoading ? '生成中…' : 'AI生成摘要')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.canAiGenerate() ? '#111827' : '#9CA3AF')
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
        }
        .layoutWeight(1)
        .height(48)
        .borderRadius(16)
        .backgroundColor('#FFFFFF')
        .shadow({
          radius: 12,
          color: 'rgba(0,0,0,0.06)',
          offsetX: 0,
          offsetY: 8
        })
        .enabled(this.canAiGenerate())
        .onClick(() => {
          this.onAIGenerate()
        })
      }
      .padding({ left: 20, right: 20, top: 16 })

      if (this.aiError.trim().length > 0) {
        Text(this.aiError)
          .fontSize(12)
          .fontColor('#B42318')
          .padding({ left: 20, right: 20, top: 10 })
      }

      Row() {
        Button() {
          Text('保存便签')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(52)
        .borderRadius(18)
        .backgroundColor(this.canSave() ? '#111827' : '#9CA3AF')
        .shadow({
          radius: 16,
          color: 'rgba(0,0,0,0.18)',
          offsetX: 0,
          offsetY: 10
        })
        .enabled(this.canSave())
        .onClick(() => {
          this.onSave()
        })
      }
      .padding({ left: 20, right: 20, top: 14, bottom: 24 })

      Column()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}
