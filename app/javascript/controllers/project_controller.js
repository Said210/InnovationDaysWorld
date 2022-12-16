import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // this.element.textContent = "Hello World!"
    var tagsLocal = jSuites.tags(document.getElementById('tags-local'), {
      search: [
          "apple",
          "watermelon",
          "orange",
          "strawberry",
          "grape",
          "cherry",
          "mango",
          "nectarine",
          "banana",
          "pomegranate"
      ],
      placeholder: 'Fruits'
    });
    
    document.querySelector("#submit_project").addEventListener("click", function(e) {
      e.preventDefault();
      document.querySelector("#project_tech_stack").value = tagsLocal.getValue();
      alert("Hello World!");
    });

  }

}
