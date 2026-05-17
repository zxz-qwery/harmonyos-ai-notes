import router from '@ohos.router'

@Entry
@Component
struct CreateNote {
  @State private title: string = ''
  @State private content: string = ''

  private goBack() {
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
        Text('标题')
          .fontSize(12)
          .fontColor('#6B7280')
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
            this.title = v
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
            this.content = v
          })
      }
      .padding({ left: 20, right: 20 })

      Row() {
        Button() {
          Row() {
            Text('AI生成摘要')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
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
        .onClick(() => {
          this.content = this.content
        })
      }
      .padding({ left: 20, right: 20, top: 16 })

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
        .backgroundColor('#111827')
        .shadow({
          radius: 16,
          color: 'rgba(0,0,0,0.18)',
          offsetX: 0,
          offsetY: 10
        })
        .onClick(() => {
          this.goBack()
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