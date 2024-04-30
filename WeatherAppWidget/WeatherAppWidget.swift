//
//  WeatherAppWidget.swift
//  WeatherAppWidget
//
//  Created by 정현 on 3/28/24.
//

import WidgetKit
import SwiftUI
import WeatherKit

struct Provider: TimelineProvider {
    // MARK: - 위젯 최초로 렌더링
    func placeholder(in context: Context) -> SimpleEntry {
      SimpleEntry(date: Date(), highTemp: "0",lowTemp: "0",temp: "0",condition: "cloud", city: "분당구")
    }
    
    // MARK: - 미리보기 타이틀
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            if let defaults = UserDefaults(suiteName: "group.com.brunidev.weatherWhat") {
                let highTemp = defaults.string(forKey: "highTemp")
                let lowTemp = defaults.string(forKey: "lowTemp")
                let temp = defaults.string(forKey: "temp")
                let condition = defaults.string(forKey: "condition")
                let city = defaults.string(forKey: "city")
                let entry = SimpleEntry(date: Date(), highTemp: highTemp ?? "",lowTemp: lowTemp ?? "",temp: temp ?? "",condition: condition ?? "",city: city ?? "")
                completion(entry)
            }else {
                let entry = SimpleEntry(date: Date(), highTemp: "0",lowTemp: "0",temp: "0",condition: "cloud", city: "분당구")
                completion(entry)
            }
        }
    }
    
    // MARK: - 위젯상태 변경
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let update = Calendar.current.date(byAdding: .minute, value: 1,to: Date())!
        Task {
            if let defaults = UserDefaults(suiteName: "group.com.brunidev.weatherWhat") {
                let highTemp = defaults.string(forKey: "highTemp")
                let lowTemp = defaults.string(forKey: "lowTemp")
                let temp = defaults.string(forKey: "temp")
                let condition = defaults.string(forKey: "condition")
                let city = defaults.string(forKey: "city")
                let entry = SimpleEntry(date: Date(), highTemp: highTemp ?? "",lowTemp: lowTemp ?? "",temp: temp ?? "",condition: condition ?? "",city: city ?? "")
                let timeline = Timeline(entries: [entry], policy: .after(update))
                completion(timeline)
            } else {
                let entry = SimpleEntry(date: Date(), highTemp: "0",lowTemp: "0",temp: "0",condition: "cloud", city: "분당구")
                let timeline = Timeline(entries: [entry], policy: .after(update))
                completion(timeline)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let highTemp : String
    let lowTemp : String
    let temp : String
    let condition : String
    let city : String
//    let city : String?
}


struct WeatherAppWidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry 
    
    var body : some View {
        SmallWidgetView(entry: entry)
    }
}
@main
struct WeatherAppWidget: Widget {
    let kind: String = "WeatherAppWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeatherAppWidgetEntryView(entry: entry)
                    .containerBackground(for: .widget){}
            }else {
                WeatherAppWidgetEntryView(entry: entry)
                .padding()
                .background()
            }
        }
        .configurationDisplayName("기본 날씨")
        .description("현재 날씨, 최고 최저 기온을 볼 수 있습니다.")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled() //이코드는 배경지우기..
    }
}

#Preview(as: .systemSmall) {
    WeatherAppWidget()
} timeline: {
    SimpleEntry(date: Date(), highTemp: "0",lowTemp: "0",temp: "0",condition: "cloud", city: "분당구")
}


extension UIImage {
  func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
    let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
    let format = imageRendererFormat
    format.opaque = isOpaque
    return UIGraphicsImageRenderer(size: canvas, format: format).image {
      _ in draw(in: CGRect(origin: .zero, size: canvas))
    }
  }
}
