//
//  SmallWidgetView.swift
//  WeatherApp
//
//  Created by 정현 on 4/26/24.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView : View {
    
    @State var entry : Provider.Entry
    
    var body: some View {
        ZStack{
            getConditionImage(condition: entry.condition)
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment : .leading) {
                Text(entry.city)
                    .font(.system(size: 16,weight: .semibold))
                    .padding(.leading,5)
                    .padding(.top,20)
                Spacer()
                HStack(alignment : .center){
                    Text(entry.temp)
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
                            Text(entry.highTemp)
                                .font(.system(size: 16,weight: .semibold))
                                .padding(.top,2)
                                .padding(.bottom,1)
                            Text(entry.lowTemp)
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
