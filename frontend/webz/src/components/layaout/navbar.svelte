<script>
  let isMenuOpen = false;
  
  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }
</script>

<nav class="navbar">
  <div class="nav-container">
    <button class="menu-button" on:click={toggleMenu}>
      <span class="hamburger" class:active={isMenuOpen}></span>
    </button>

    <div class="nav-links" class:active={isMenuOpen}>
      <a href="/" class="nav-link">Inicio</a>
      <a href="/galeria" class="nav-link">Galería</a>
      <a href="/contacto" class="nav-link">Contacto</a>
      <a href="/admin" class="nav-link">Admin</a>
    </div>
  </div>
</nav>

<style>
  .navbar {
    position: fixed;
    top: 2rem;
    left: 50%;
    transform: translateX(-50%);
    z-index: 1000;
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(8px);
    border-radius: 30px;
    padding: 0.5rem 1.5rem;
    width: auto;
    min-width: 300px;
  }

  .nav-container {
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .nav-links {
    display: flex;
    gap: 1.5rem;
    align-items: center;
  }

  .nav-link {
    color: #333;
    text-decoration: none;
    font-weight: 500;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    padding: 0.3rem 0.8rem;
    border-radius: 15px;
  }

  .nav-link:hover {
    background: rgba(255, 255, 255, 0.3);
    color: #ff3e00;
  }

  .menu-button {
    display: none;
    background: none;
    border: none;
    cursor: pointer;
    padding: 0.5rem;
  }

  @media (max-width: 768px) {
    .navbar {
      width: auto;
      min-width: 200px;
      top: 1rem;
    }

    .menu-button {
      display: block;
    }

    .nav-links {
      display: none;
      position: absolute;
      top: 100%;
      left: 50%;
      transform: translateX(-50%);
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(8px);
      border-radius: 15px;
      padding: 1rem;
      margin-top: 0.5rem;
      flex-direction: column;
      align-items: center;
      min-width: 150px;
    }

    .nav-links.active {
      display: flex;
    }

    .hamburger {
      display: block;
      width: 20px;
      height: 2px;
      background: #333;
      position: relative;
      transition: all 0.3s ease;
    }

    .hamburger:before,
    .hamburger:after {
      content: '';
      position: absolute;
      width: 20px;
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
