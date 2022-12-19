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

  }

  filter_projects() {
    const checkboxes = document.querySelectorAll('input[name="tech_stack[]"]');
    let selected_tech_stack = [];
    document.querySelectorAll('input[name="tech_stack[]"]').forEach((checkbox) => {
      if(checkbox.checked) { selected_tech_stack.push(checkbox.value) }
    })
    console.log(selected_tech_stack);
    if (selected_tech_stack.length == 0) {
      document.querySelectorAll(".project-card").forEach((project) => {
        project.classList.remove("hidden");
      });
      return;
    }
    document.querySelectorAll(".project-card").forEach((project) => {
      project.classList.add("hidden");
    });

    selected_tech_stack.forEach((tech) => {
      document.querySelectorAll(".project-card").forEach((project) => {
        if ( project.querySelector(".project-techstack").textContent.includes(tech)  ) {
          project.classList.remove("hidden");
        }
      });
    });

  }
}
