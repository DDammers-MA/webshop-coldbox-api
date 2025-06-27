component {

  function onInvalidHTTPMethod(event, rc, prc) {
    event.getResponse().setStatus(200);
    event.getResponse().addHeader("Access-Control-Allow-Origin", "http://localhost:4200");
    event.getResponse().addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    event.getResponse().addHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
    event.getResponse().addHeader("Access-Control-Allow-Credentials", "true");

    event.renderData(type="json", data={ message = "Handled invalid HTTP method (CORS preflight?)" });
  }

}
