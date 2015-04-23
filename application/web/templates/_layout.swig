<!doctype html>

<html ng-app='app'>
  <head>
    <!-- title -->
    <title>{% block title %}{{title}}{% endblock %}</title>

    <!-- General META -->
    <meta charset="utf-8">
    <meta http-equiv="Content-type" content="text/html;charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- Semantic META -->
    <meta name="keywords" content="{{keywords}}">
    <meta name="description" content="{{description}}">

    <link rel="stylesheet" href="/static/assets/styles/application.css">

  </head>
  <body class="light">
    {% block content %}{% endblock %}
    <script src="/static/assets/scripts/application.js"></script>
    {% if NODE_ENV == 'development' && livereload %}
      <script src="http://{{livereload.host}}:{{livereload.port}}/livereload.js">
      </script>
    {% endif %}
  </body>
</html>
