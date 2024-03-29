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
        SimpleEntry(date: .now, temp: 0,condition: "rain",hightemp: 0,lowtemp: 0,location: "Bundang")
    }
    
    // MARK: - 미리보기 타이틀
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: .now, temp: 0,condition: "rain",hightemp: 0,lowtemp: 0,location: "Bundang")
        completion(entry)
    }
    
    // MARK: - 위젯상태 변경
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry =  SimpleEntry(date: .now, temp: 0,condition: "rain",hightemp: 0,lowtemp: 0,location: "Bundang")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
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
            getConditionImage(condition: UserDefaults.shared.string(forKey: "weatherCondition") ?? "snow")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment : .leading) {
                Text("\(UserDefaults.shared.string(forKey: "nowLocation")!)")
                    .font(.system(size: 16,weight: .semibold))
                    .padding(.leading,5)
                    .padding(.top,20)
                Spacer()
                HStack(alignment : .center){
                    Text("\(UserDefaults.shared.string(forKey: "nowTemperature")!)°")
                        .font(.system(size: 50,weight: .bold))
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
                            Text("\(UserDefaults.shared.string(forKey: "highTemp")!)°")
                                .font(.system(size: 16,weight: .semibold))
                                .padding(.top,2)
                                .padding(.bottom,1)
                            Text("\(UserDefaults.shared.string(forKey: "lowTemp")!)°")
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
            } else {
                WeatherAppWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled() //이코드는 배경지우기..
    }
}

#Preview(as: .systemSmall) {
    WeatherAppWidget()
} timeline: {
    SimpleEntry(date: .now, temp: 0,condition: "rain",hightemp: 0,lowtemp: 0,location: "Bundang")
    SimpleEntry(date: .now, temp: 0,condition: "rain",hightemp: 0,lowtemp: 0,location: "Bundang")
}

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.brunidev.weatherWhat"
        return UserDefaults(suiteName: appGroupId)!
    }
}
