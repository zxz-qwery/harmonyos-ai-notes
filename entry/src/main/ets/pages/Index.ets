import router from '@ohos.router'
import type { Note } from '../model/NoteModel'
import StorageService from '../service/StorageService'

type MoodType = 'positive' | 'negative'

@Entry
@Component
struct Index {
  @State private keyword: string = ''
  @State private noteList: Note[] = []

  private storage: StorageService | null = null

  private getStorage(): StorageService {
    if (this.storage) {
      return this.storage
    }
    this.storage = new StorageService(getContext(this))
    return this.storage
  }

  private moodText(mood: string): string {
    return mood === 'negative' ? '😔 消极' : '😊 积极'
  }

  private moodBg(mood: string): string {
    return mood === 'negative' ? '#F3F4F6' : '#EAF9F0'
  }

  private moodFg(mood: string): string {
    return mood === 'negative' ? '#6B7280' : '#117A37'
  }

  private buildMockNotes(): Note[] {
    const n1: Note = {
      id: '1',
      title: '产品灵感：AI 便签首页',
      content: '希望首页更像真实产品：搜索、卡片、情绪标签、时间信息一眼可读，整体留白克制。',
      time: '今天 09:12',
      mood: 'positive' as MoodType
    }
    const n2: Note = {
      id: '2',
      title: '会议纪要',
      content: '1) 下周上线 MVP；2) 增加快捷创建入口；3) 详情页突出内容与情绪分析结果。',
      time: '昨天 20:48',
      mood: 'negative' as MoodType
    }
    const n3: Note = {
      id: '3',
      title: '灵感随记',
      content: '把“写作体验”做成核心：字体舒服、行距合理、卡片阴影轻，像 Notion 一样干净。',
      time: '05-16 14:06',
      mood: 'positive' as MoodType
    }
    const n4: Note = {
      id: '4',
      title: '待办清单',
      content: '优化列表性能；支持长按操作；增加空状态；统一间距与圆角规范。',
      time: '05-15 10:33',
      mood: 'negative' as MoodType
    }

    return [n1, n2, n3, n4]
  }

  async aboutToAppear(): Promise<void> {
    await this.loadNotes()
  }

  async onPageShow(): Promise<void> {
    await this.refreshNotes()
  }

  private async refreshNotes(): Promise<void> {
    const local: Note[] = await this.getStorage().getNotes()
    if (local.length > 0) {
      this.noteList = local
    }
  }

  private async loadNotes(): Promise<void> {
    const storage = this.getStorage()
    const local: Note[] = await storage.getNotes()
    if (local.length > 0) {
      this.noteList = local
      return
    }

    const init: Note[] = this.buildMockNotes()
    this.noteList = init
    await storage.saveNotes(init)
  }

  private toDetail(note: Note) {
    router.pushUrl({
      url: 'pages/Detail',
      params: {
        id: note.id
      }
    })
  }

  private toCreate() {
    router.pushUrl({ url: 'pages/CreateNote' })
  }

  private async onDelete(id: string): Promise<void> {
    const next: Note[] = this.noteList.filter(item => item.id !== id)
    this.noteList = next
    await this.getStorage().saveNotes(next)
  }

  build() {
    Stack() {
      Column() {
        Column() {
          Text('AI Notes')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')

          Row() {
            Text('🔍')
              .fontSize(16)
              .fontColor('#6B7280')
              .margin({ right: 8 })

            TextInput({ text: this.keyword, placeholder: '搜索便签（仅 UI）' })
              .fontSize(15)
              .fontColor('#111827')
              .placeholderColor('#9CA3AF')
              .backgroundColor(Color.Transparent)
              .layoutWeight(1)
              .height(44)
              .onChange((v: string) => {
                this.keyword = v
              })
          }
          .padding({ left: 14, right: 14 })
          .height(46)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ top: 14 })
          .shadow({
            radius: 14,
            color: 'rgba(0,0,0,0.06)',
            offsetX: 0,
            offsetY: 8
          })
        }
        .padding({ left: 20, right: 20, top: 18, bottom: 10 })

        List({ space: 14 }) {
          ForEach(this.noteList, (note: Note) => {
            ListItem() {
              Column() {
                Row() {
                  Text(note.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111827')
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .layoutWeight(1)

                  Row() {
                    if (note.mood === 'negative') {
                      Row() {
                        Text(this.moodText(note.mood))
                          .fontSize(12)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(this.moodFg(note.mood))
                      }
                      .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                      .backgroundColor(this.moodBg(note.mood))
                      .borderRadius(999)
                    } else {
                      Row() {
                        Text(this.moodText(note.mood))
                          .fontSize(12)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(this.moodFg(note.mood))
                      }
                      .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                      .backgroundColor(this.moodBg(note.mood))
                      .borderRadius(999)
                    }

                    Button() {
                      Text('🗑')
                        .fontSize(14)
                        .fontColor('#6B7280')
                    }
                    .width(34)
                    .height(34)
                    .borderRadius(999)
                    .backgroundColor('#F3F4F6')
                    .margin({ left: 10 })
                    .padding(0)
                    .onClick(() => {
                      this.onDelete(note.id)
                    })
                  }
                }

                Text(note.content)
                  .fontSize(14)
                  .fontColor('#4B5563')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ top: 8 })

                Row() {
                  Text(note.time)
                    .fontSize(12)
                    .fontColor('#9CA3AF')
                }
                .margin({ top: 12 })
              }
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(18)
              .shadow({
                radius: 18,
                color: 'rgba(0,0,0,0.08)',
                offsetX: 0,
                offsetY: 10
              })
            }
            .padding({ left: 20, right: 20 })
            .onClick(() => this.toDetail(note))
          }, (note: Note) => note.id)
        }
        .layoutWeight(1)
        .edgeEffect(EdgeEffect.None)
        .padding({ top: 6, bottom: 92 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F6F8')

      Button() {
        Text('+')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#111827')
      .position({ x: '80%', y: '86%' })
      .shadow({
        radius: 18,
        color: 'rgba(0,0,0,0.22)',
        offsetX: 0,
        offsetY: 12
      })
      .onClick(() => this.toCreate())
    }
    .width('100%')
    .height('100%')
  }
}
