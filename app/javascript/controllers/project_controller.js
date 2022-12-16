import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Project Controller Connected");
    // this.element.textContent = "Hello World!"
    var tagsLocal = jSuites.tags(document.getElementById('tags-local'), {
      search: document.getElementById('tags-local').attributes['data-tech-list'].value.split(","),
      placeholder: 'Tech Stack'
    });

    tagsLocal.setValue(document.getElementById("project_tech_stack").value);

    document.querySelector("#submit_project").addEventListener("click", function(e) {
      e.preventDefault();
      document.querySelector("#project_tech_stack").value = tagsLocal.getValue();
      document.querySelector("#new_project_form").submit();
    });

  }

}
