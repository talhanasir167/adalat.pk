import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  add_service(e) {
    e.target.parentElement.remove();
    let serviceIndex = Number(this.element.getAttribute("data-service-index")) + 1;
    let levelOptions = JSON.parse(this.element.getAttribute("data_proficiency_levels"));
    let serviceOptions = JSON.parse(this.element.getAttribute("data-service-options"));

    const newRow = document.createElement('div');
    newRow.classList.add('row', 'service', 'mt-3');

    newRow.appendChild(this.getNewServiceField(serviceIndex, serviceOptions));
    newRow.appendChild(this.getNewProficiencyField(serviceIndex, levelOptions));
    this.element.appendChild(newRow);
    if (this.element.querySelectorAll('.service').length < serviceOptions.length) {
      this.element.appendChild(this.getNewAddServiceBtn());
    }
    this.element.setAttribute("data-service-index", serviceIndex);
  }

  remove_service(e) {
    e.target.closest('.row').remove();
    let serviceOptions = JSON.parse(this.element.getAttribute("data-service-options"));
    let addServiceBtn = this.element.querySelector('.add-service-btn');

    if (this.element.querySelectorAll('.service').length < serviceOptions.length && !addServiceBtn ) {
      this.element.appendChild(this.getNewAddServiceBtn());
    }
  }

  getNewProficiencyField(serviceIndex, levelOptions) {
    const proficiencyField = document.createElement('div');
    proficiencyField.classList.add('col-md', 'field');
    const selectOptions = levelOptions.map(option => `<option value="${option}">${option}</option>`).join("");
    proficiencyField.innerHTML = `
      <label class="form-label text-muted">Service proficiency</label><br />
      <div class="d-flex">
        <select name="user[user_services_attributes][${serviceIndex}][service_proficiency]" class="form-select">
          ${selectOptions}
        </select>
        <a data-action="services#remove_service" class="align-self-center fs-4 ms-2 text-danger"><i class="bi bi-x-circle"></i></a>
      </div>
    `;
    return proficiencyField;
  }

  getNewServiceField(serviceIndex, serviceOptions) {
    const newServiceField = document.createElement('div');
    newServiceField.classList.add('col-md', 'field');
    const selectOptions = serviceOptions.map(option => `<option value="${option[1]}">${option[0]}</option>`).join("");
    newServiceField.innerHTML = `
      <label class="form-label text-muted">Service</label><br />
      <select name="user[user_services_attributes][${serviceIndex}][service_id]" 
              id="user_user_services_attributes_${serviceIndex}_service_id" class="form-select">
        ${selectOptions}
      </select>
    `;
    return newServiceField;
  }

  getNewAddServiceBtn() {
    const newElement = document.createElement('div');
    newElement.classList.add('text-end', 'add-service-btn');
    newElement.innerHTML = `
      <a  data-action="services#add_service" class = "btn btn-outline-success mt-3" ><i class="bi bi-plus-lg"></i> Add more</a>
    `;
    return newElement;
  }
}
