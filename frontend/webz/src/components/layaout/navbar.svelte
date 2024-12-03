<script>
  let isMenuOpen = false;
  
  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }
</script>

<nav class="navbar">
  <div class="nav-brand">
    <a href="/" class="logo">Gloglokigs</a>
  </div>

  <button class="menu-button" on:click={toggleMenu}>
    <span class="hamburger" class:active={isMenuOpen}></span>
  </button>

  <div class="nav-links" class:active={isMenuOpen}>
    <a href="/" class="nav-link">Inicio</a>
    <a href="/galeria" class="nav-link">Galería</a>
    <a href="/contacto" class="nav-link">Contacto</a>
    <a href="/admin" class="nav-link login-btn">Admin</a>
  </div>
</nav>

<style>
  .navbar {
    background: #ffffff;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
  }

  .logo {
    font-size: 1.5rem;
    font-weight: bold;
    color: rgb(0, 0, 0);
    text-decoration: none;
    transition: color 0.3s ease;
  }

  .logo:hover {
    color: #ac6151;
  }

  .nav-links {
    display: flex;
    gap: 2rem;
    align-items: center;
  }

  .nav-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s ease;
    position: relative;
  }

  .nav-link:after {
    content: '';
    position: absolute;
    width: 0;
    height: 2px;
    bottom: -4px;
    left: 0;
    background-color: #ff3e00;
    transition: width 0.3s ease;
  }

  .nav-link:hover:after {
    width: 100%;
  }

  .login-btn {
    background: #000000;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    transition: background 0.3s ease;
  }

  .login-btn:hover {
    background: #ff6240;
  }

  .login-btn:after {
    display: none;
  }

  .menu-button {
    display: none;
    background: none;
    border: none;
    cursor: pointer;
    padding: 0.5rem;
  }

  .hamburger {
    display: block;
    width: 24px;
    height: 2px;
    background: #333;
    position: relative;
    transition: all 0.3s ease;
  }

  .hamburger:before,
  .hamburger:after {
    content: '';
    position: absolute;
    width: 24px;
    height: 2px;
    background: #333;
    transition: all 0.3s ease;
  }

  .hamburger:before {
    top: -6px;
  }

  .hamburger:after {
    bottom: -6px;
  }

  @media (max-width: 768px) {
    .menu-button {
      display: block;
    }

    .nav-links {
      display: none;
      position: absolute;
      top: 100%;
      left: 0;
      right: 0;
      background: white;
      padding: 1rem;
      flex-direction: column;
      align-items: center;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .nav-links.active {
      display: flex;
    }

    .hamburger.active {
      background: transparent;
    }

    .hamburger.active:before {
      transform: rotate(45deg);
      top: 0;
    }

    .hamburger.active:after {
      transform: rotate(-45deg);
      bottom: 0;
    }
  }
</style>
