Omphalo.AuthRegisterView = Ember.View.extend
  templateName: "auth/register"

  name: ''
  email: ''
  password: ''
  password_confirmation: ''
  errors: null
  submitting: false

  submit: (event, view) ->
    event.preventDefault()
    event.stopPropagation()
    @set 'errors', null
    @set 'submitting', true
    $.ajax
      url: '/users'
      type: "POST"
      dataType: "json"
      data:
        "user[name]": @get 'name'
        "user[email]": @get 'email'
        "user[password]": @get 'password'
        "user[password_confirmation]": @get 'password_confirmation'
      success: =>
        @get('context').auth.signIn
          dataType: "json"
          data:
            "email": @get 'email'
            "password": @get 'password'
        lightbox = Ember.View.views[$(".ember-lightbox").attr('id')]
        lightbox.set 'visible', false
        Omphalo.setFlash("Registration successful.", 'notice')
      error: (response) =>
        @set 'errors', response.responseJSON
      complete: =>
        @set 'submitting', false