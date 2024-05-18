<!DOCTYPE html>
<html lang="pt">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TaskMaster - Iniciar Sessão</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  body {
    background-color: #f8f9fa;
    font-family: Arial, sans-serif;
  }
  .navbar-brand {
    font-size: 1.8rem;
    font-weight: bold;
  }
  .form-title {
    font-size: 2rem;
    font-weight: bold;
    color: #495057;
    margin-bottom: 30px;
  }
  .labels {
    font-weight: bold;
  }
  .form-control {
    border-radius: 20px;
  }
  .btn-success {
    background-color: #4caf50;
    border-color: #4caf50;
    border-radius: 20px;
    font-weight: bold;
    padding: 10px 30px;
  }
  .btn-success:hover {
    background-color: #45a049;
    border-color: #45a049;
  }
</style>

</head>
<body>
<header>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container">
    <a class="navbar-brand" href="login.jsp">TASKMASTER</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="login.jsp">Iniciar Sessão</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="register.jsp">Registo</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</header>

<main class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6 bg-white p-5 rounded shadow">
      <h2 class="text-center form-title mb-4">Iniciar Sessão</h2>
      <% 
        String status = (String)request.getAttribute("status");
        if (status != null) {
          if (status.equals("emptyFields")) {
      %>
      <div class="alert alert-danger" role="alert">
        Por favor, preencha todos os campos.
      </div>
      <% 
          } else if (status.equals("invalidCredentials")) {
      %>
      <div class="alert alert-danger" role="alert">
        Credenciais inválidas. Por favor, verificar email e password .
      </div>
      <% 
          }
        }
      %>
      <form method="post" action="Login">
        <div class="mb-3 row">
          <label for="email" class="col-sm-3 col-form-label labels">Email:</label>
          <div class="col-sm-9">
            <input type="email" class="form-control" id="email" name="email">
          </div>
        </div>
        <div class="mb-3 row">
          <label for="password" class="col-sm-3 col-form-label labels">Password:</label>
          <div class="col-sm-9">
            <input type="password" class="form-control" id="password" name="password">
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3"></div>
          <div class="col-sm-9">
            <button type="submit" class="btn btn-success btn-lg btn-block">Iniciar Sessão</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</main>

<footer class="fixed-bottom">
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</footer>
</body>
</html>
