# Telly-Ho
Telly-Ho is a CLI program designed to help you find your next TV show by accessing the [TVmaze API](http://www.tvmaze.com/api). Using simple characteristics like date and genre, you can narrow down your watching options to a short list. From there, you can select a show to receive its showtimes and summary.
## Installation
- Ensure that you have [Ruby](https://www.ruby-lang.org/en/downloads/) installed properly
- Begin by cloning the repository and navigating to the download location
- Make sure that you have all necessary gems by running:
```
bundle install
```
## Usage
### Starting the program
To start the application:
```
ruby bin/run
```
### How to use the program
Telly-Ho will provide all of the necessary prompts - they are listed here for your convenience:
- The application will only pull dates from the current year. You may use today's date by entering `today` or you may select a date with the (mm-dd) format, such as `05-25`.
- You will be brought to a menu of show types (or a menu of show genres, if there are no shows with a 'type' attribute on the selected date). From here, you may enter either the number listed or the name, `Documentary`.
  - Alternatively, you may choose to continue your search with genre by entering `genre` or the indicated number. The following steps will remain the same.
- You will be brought to a list of shows that match the type selected. A show may be selected only by the number indicated. This will bring up more details about the show.
- You may enter `back` to return to the shows matching your search selection, `more shows` to see more shows on your specified date, or `new date` to restart the application and select a new date.
- When you have found your show, or at any point during the application, you may enter `exit` to exit the program.
## License
The program is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)
## Collaborating
Pull Requests are welcome on [GitHub](https://github.com/rebeccahickson/telly-ho). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://github.com/cjbrock/worlds-best-restaurants-cli-gem/blob/master/contributor-covenant.org) code of conduct.
