<script>
 import { isAuthenticated } from '../';
  
  let username = '';
  let password = '';
  let error = '';

  async function handleLogin() {
    try {
      const response = await fetch('http://localhost:8000/api-auth/login/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        credentials: 'include',
        body: JSON.stringify({ username, password }),
      });

      if (response.ok) {
        const data = await response.json();
        if (data.is_staff) {
          localStorage.setItem('isAdmin', 'true');
          isAuthenticated.set(true);
        } else {
          error = 'Solo administradores pueden acceder';
        }
      } else {
        error = 'Credenciales inválidas';
      }
    } catch (e) {
      error = 'Error de conexión';
    }
  }
</script>

<div class="login-container">
  <h2>Iniciar Sesión</h2>
  
  {#if error}
    <div class="error">{error}</div>
  {/if}

  <form on:submit|preventDefault={handleLogin}>
    <div class="form-group">
      <label for="username">Usuario:</label>
      <input
        type="text"
        id="username"
        bind:value={username}
        required
      />
    </div>

    <div class="form-group">
      <label for="password">Contraseña:</label>
      <input
        type="password"
        id="password"
        bind:value={password}
        required
      />
    </div>

    <button type="submit">Entrar</button>
  </form>
</div>

<style>
  .login-container {
    max-width: 400px;
    margin: 2rem auto;
    padding: 2rem;
    border: 1px solid #ddd;
    border-radius: 8px;
  }

  .form-group {
    margin-bottom: 1rem;
  }

  label {
    display: block;
    margin-bottom: 0.5rem;
  }

  input {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  button {
    width: 100%;
    padding: 0.75rem;
    background: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background: #45a049;
  }

  .error {
    color: red;
    margin-bottom: 1rem;
  }
</style> 