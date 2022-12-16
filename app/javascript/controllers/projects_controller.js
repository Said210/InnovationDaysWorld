import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Project Dashboard Controller Connected");

    document.addEventListener('turbo:before-stream-render', function(event) {
      console.log("Frame updated",this.projectTargets);

      // this.projectsTarget.innerHTML = event.detail.newBody.innerHTML;
    })

    document.querySelectorAll('input[name="tech_stack[]"]').forEach((checkbox) => {
      checkbox.addEventListener("change", (event) => {
        console.log("Checkbox changed", event);
        this.filter_projects();
      })
    });

    document.getElementById("filter_button").addEventListener("click", (event) => {
      console.log("Filter button clicked", event);
      this.filter_projects();
    });
  }

  filter_projects() {
    const checkboxes = document.querySelectorAll('input[name="tech_stack[]"]');
    let selected_tech_stack = [];
    document.querySelectorAll('input[name="tech_stack[]"]').forEach((checkbox) => {
      if(checkbox.checked) { selected_tech_stack.push(checkbox.value) }
    })
    console.log(selected_tech_stack);
    document.querySelectorAll(".project-card").forEach((project) => {
      if (selected_tech_stack.length == 0) {
        project.classList.remove("hidden");
        return;
      }
      selected_tech_stack.forEach((tech) => {
        if ( project.querySelector(".project-techstack").textContent.includes(tech)  ) {
          project.classList.remove("hidden");
        } else {
          project.classList.add("hidden");
        }
      });
    });

  }
}
