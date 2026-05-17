import router from '@ohos.router'

type MoodType = 'positive' | 'negative'

interface NoteItem {
  id: number
  title: string
  content: string
  time: string
  mood: MoodType
}

@Entry
@Component
struct Index {
  @State private keyword: string = ''
  @State private notes: NoteItem[] = [
    {
      id: 1,
      title: '产品灵感：AI 便签首页',
      content: '希望首页更像真实产品：搜索、卡片、情绪标签、时间信息一眼可读，整体留白克制。',
      time: '今天 09:12',
      mood: 'positive'
    },
    {
      id: 2,
      title: '会议纪要',
      content: '1) 下周上线 MVP；2) 增加快捷创建入口；3) 详情页突出内容与情绪分析结果。',
      time: '昨天 20:48',
      mood: 'negative'
    },
    {
      id: 3,
      title: '灵感随记',
      content: '把“写作体验”做成核心：字体舒服、行距合理、卡片阴影轻，像 Notion 一样干净。',
      time: '05-16 14:06',
      mood: 'positive'
    },
    {
      id: 4,
      title: '待办清单',
      content: '优化列表性能；支持长按操作；增加空状态；统一间距与圆角规范。',
      time: '05-15 10:33',
      mood: 'negative'
    }
  ]

  private moodText(mood: MoodType): string {
    return mood === 'positive' ? '积极😊' : '消极😔'
  }

  private moodBg(mood: MoodType): string {
    return mood === 'positive' ? '#EAF9F0' : '#FDECEC'
  }

  private moodFg(mood: MoodType): string {
    return mood === 'positive' ? '#117A37' : '#B42318'
  }

  private toDetail(note: NoteItem) {
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
          ForEach(this.notes, (note: NoteItem) => {
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
                    Text(this.moodText(note.mood))
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.moodFg(note.mood))
                  }
                  .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                  .backgroundColor(this.moodBg(note.mood))
                  .borderRadius(999)
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
          }, (note: NoteItem) => note.id.toString())
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
          .onClick(() => {
            router.pushUrl({
              url: 'pages/CreateNote'
            })
          })
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