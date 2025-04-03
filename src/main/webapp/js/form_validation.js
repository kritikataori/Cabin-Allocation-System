(function () {
    'use strict'
    var forms = document.querySelectorAll('.needs-validation')
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }
            form.classList.add('was-validated')
        }, false)
    })
})()

const forms = document.querySelectorAll('form');
forms.forEach(form => {
  form.addEventListener('submit', function(e) {
    // Disable submit button once clicked
    const submitBtn = this.querySelector('button[type="submit"]');
    if (submitBtn) {
      submitBtn.disabled = true;
    }
  });
});