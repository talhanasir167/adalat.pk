import { Controller } from "@hotwired/stimulus"
import 'quill'
export default class extends Controller {
 static targets = ["quillEditor"]

  connect() {
    this.quill = new Quill(this.quillEditorTarget, {
      modules: { toolbar: this.get_tollbar_btns() },
      placeholder: 'Description in detail... ',
      theme: 'snow'
    });
    var input_field = document.getElementById("user-description")
    this.quill.container.firstChild.innerHTML = input_field.value;
    this.quill.on('text-change', (delta, oldDelta, source) => {
      document.getElementById("user-description").value = this.quill.container.firstChild.innerHTML;
    });
  }

  get_tollbar_btns() {
    return [
      [{ 'font': [] }],
      ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
      ['blockquote'],
  
      [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  
      [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
  
      [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
      [{ 'align': [] }],
      ['link'],
        
      ['clean']    
    ]
  }

  disconnect() { if (this.quill) this.quill = null; }
}
