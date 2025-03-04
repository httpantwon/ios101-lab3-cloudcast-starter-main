//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Antwon Walls on 3/6/24.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private var forecasts = [WeatherForecast]() //tracks all of the possible forecasts
    private var selectedForecastIndex = 0 // tracks which forecast is being shown, defaults to 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        forecasts = createMockData()
        configure(with: forecasts[selectedForecastIndex]) // configures the UI to show the first mock data
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
    @IBAction func didTapForwardButton(_ sender: UIButton) {
        /* Don't go higher than the number of forecasts */
        selectedForecastIndex = min(forecasts.count - 1, selectedForecastIndex + 1)
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    // Returns an array of fake WeatherForecaast data models to show
    private func createMockData() -> [WeatherForecast] {
        // This is just using the Calendar API to get a few random dates
        let today = Date()
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)!
        let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
        
        let mockData1 = WeatherForecast(temperature: 59.5, date: today, weatherCode: .violentRainShowers, windSpeed: 3.3, precipitation: 33.3)
        let mockData2 = WeatherForecast(temperature: 65.5, date: tomorrow, weatherCode: .fog, windSpeed: 3.7, precipitation: 13.3)
        let mockData3 = WeatherForecast( temperature: 49.5, date: dayAfterTomorrow, weatherCode: .partlyCloudy, windSpeed: 2.8,  precipitation: 23.3)
        
        return [mockData1, mockData2, mockData3]
    }
    
    private func configure(with forecast: WeatherForecast) {
        forecastImageView.image = forecast.weatherCode.image
        descriptionLabel.text = forecast.weatherCode.description
        temperatureLabel.text = "\(forecast.temperature)°F"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: forecast.date)
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


