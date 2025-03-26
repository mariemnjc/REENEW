import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()




export default class extends Controller {
  connect() {

    flatpickr(this.element, {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      minDate: "today",
      maxDate: new Date().fp_incr(14), // 14 days from now
      "disable": [
        function(date) {
            // return true to disable
            return (date.getDay() === 0 || date.getDay() === 6);

        }
      ],
      "locale": {
          "firstDayOfWeek": 1 // start week on Monday
      }
    })

  }

}
