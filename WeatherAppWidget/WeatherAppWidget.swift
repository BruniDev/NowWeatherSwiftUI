//
//  WeatherAppWidget.swift
//  WeatherAppWidget
//
//  Created by 정현 on 3/28/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    // MARK: - 위젯 최초로 렌더링
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: .now, temp:0.0,condition: "rain",hightemp:0.0,lowtemp: 0.0,location: "Bundang")
    }
    
    // MARK: - 미리보기 타이틀
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: .now, temp: 14,condition: "rain",hightemp: 16,lowtemp: 13,location: "성남시 분당구")
        completion(entry)
    }
    
    // MARK: - 위젯상태 변경
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry =  SimpleEntry(date: entryDate, temp: getTemp(),condition: getCondition() ,hightemp: getHighTemp(),lowtemp:getLowTemp(), location: getLocation() )
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getTemp() -> Double {
        return UserDefaults.shared.double(forKey: "nowTemperature")
    }
    
    func getHighTemp() -> Double {
        return UserDefaults.shared.double(forKey: "highTemp")
    }
    
    func getLowTemp() -> Double {
        return UserDefaults.shared.double(forKey: "lowTemp")
    }
    
    func getLocation() -> String {
        return UserDefaults.shared.string(forKey: "nowLocation") ?? "Bundang"
    }
    
    func getCondition() -> String {
        return  UserDefaults.shared.string(forKey: "weatherCondition") ?? "snow"
    }
    
    
    
}

func getConditionImage(condition : String) -> Image {
    if condition == "cloud" || condition == "cloud.moon" || condition == "Cloudy"{
        return Image("cloud")
    } else if condition == "cloud.rain" || condition == "rain" || condition == "cloud.moon.rain"{
        return Image("rain")
    } else if condition == "wind" {
        return Image("storm")
    } else if condition == "moon" {
        return Image("sun")
    }
    else if condition == "snow" {
        return Image("snow")
    }
    else {
        return Image("sun")
    }
}
struct SimpleEntry: TimelineEntry {
    let date: Date
    let temp : Double
    let condition : String
    let hightemp : Double
    let lowtemp : Double
    let location : String
}

struct WeatherAppWidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            getConditionImage(condition: entry.condition)
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment : .leading) {
                Text(entry.location)
                    .font(.system(size: 16,weight: .semibold))
                    .padding(.leading,5)
                    .padding(.top,20)
                Spacer()
                HStack(alignment : .center){
                    Text("\(Int(entry.temp))°")
                        .font(.system(size: 35,weight: .bold))
                        .padding(.leading,5)
                    HStack{
                        VStack {
                            Text("\(Image(systemName:"arrowtriangle.up.fill"))")
                                .font(.system(size: 16,weight: .semibold))
                                .padding(.bottom,1)
                            Text("\(Image(systemName:"arrowtriangle.down.fill"))")
                                .font(.system(size: 16,weight: .semibold))
                        }
                        .padding(.trailing,0)
                        VStack {
                            Text("\(Int(entry.hightemp))°")
                                .font(.system(size: 16,weight: .semibold))
                                .padding(.top,2)
                                .padding(.bottom,1)
                            Text("\(Int(entry.lowtemp))°")
                                .font(.system(size: 16,weight: .semibold))
                        }
                    }
                    .padding(.trailing,5)
                }
                .padding(.bottom,10)
                
            }
        }
        
    }
}

struct WeatherAppWidget: Widget {
    let kind: String = "WeatherAppWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeatherAppWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
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
    SimpleEntry(date: .now, temp: 0.0,condition: "rain",hightemp: 0.0,lowtemp: 0.0,location: "Bundang")
    SimpleEntry(date: .now, temp: 0.0,condition: "rain",hightemp: 0.0,lowtemp: 0.0,location: "Bundang")
}

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.brunidev.weatherWhat"
        return UserDefaults(suiteName: appGroupId)!
    }
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
