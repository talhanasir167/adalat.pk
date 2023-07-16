import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    document.getElementById('user-roles').addEventListener('change', this.updateUserSummary);
  }

  read_more(event) {
    event.preventDefault();
    event.target.classList.add('d-none');
    let desElement = document.getElementById('short-description');
    desElement.classList.remove('read-less');
    desElement.classList.add('read-more');
    document.getElementById('read-less').classList.remove('d-none');
  }

  read_less(event) {
    event.preventDefault();
    event.target.classList.add('d-none');
    let desElement = document.getElementById('short-description');
    desElement.classList.remove('read-more');
    desElement.classList.add('read-less');
    document.getElementById('read-more').classList.remove('d-none');
  }

  updateUserSummary(e) {
    if (e.target.value == 'Client') {
      document.getElementById('user-summary-form').classList.add('d-none');
    }
    else {
      document.getElementById('user-summary-form').classList.remove('d-none');
    }
  }
}
