import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  read_more(event) {
    event.preventDefault();
    event.target.classList.add('d-none');
    let desElement = document.getElementById('short-description');
    desElement.classList.remove('read-less', 'p-3');
    desElement.classList.add('read-more', 'p-5');
    document.getElementById('read-less').classList.remove('d-none');
  }

  read_less(event) {
    event.preventDefault();
    event.target.classList.add('d-none');
    let desElement = document.getElementById('short-description');
    desElement.classList.remove('read-more', 'p-5');
    desElement.classList.add('read-less', 'p-3');
    document.getElementById('read-more').classList.remove('d-none');
  }
}
