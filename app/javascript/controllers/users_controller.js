import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

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
}
