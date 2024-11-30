<script>
  import { onMount } from 'svelte';

  let items = [];
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      const response = await fetch('http://localhost:8000/api/content/');
      items = await response.json();
    } catch (e) {
      error = 'Error al cargar los datos';
    } finally {
      loading = false;
    }
  });
</script>

<div class="home-container">
  <header class="hero">
    <h1>Bienvenido a WebZ</h1>
    <p>Descubre nuestra colección de contenido exclusivo</p>
  </header>

  <main class="content">
    {#if loading}
      <div class="loading">Cargando contenido...</div>
    {:else if error}
      <div class="error">{error}</div>
    {:else}
      <div class="grid">
        {#each items as item}
          <div class="card">
            {#if item.image}
              <img src={`http://localhost:8000${item.image}`} alt={item.title} />
            {/if}
            <div class="card-content">
              <h2>{item.title}</h2>
              {#if item.link}
                <a href={item.link} target="_blank" rel="noopener noreferrer" class="btn">
                  Ver más
                </a>
              {/if}
            </div>
          </div>
        {/each}
      </div>
    {/if}
  </main>
</div>

<style>
  .home-container {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
  }

  .hero {
    text-align: center;
    padding: 4rem 0;
    background: linear-gradient(135deg, #ff3e00 0%, #ff8700 100%);
    color: white;
    border-radius: 10px;
    margin-bottom: 2rem;
  }

  .hero h1 {
    font-size: 3rem;
    margin-bottom: 1rem;
  }

  .hero p {
    font-size: 1.2rem;
    opacity: 0.9;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
    padding: 1rem;
  }

  .card {
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
  }

  .card:hover {
    transform: translateY(-5px);
  }

  .card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
  }

  .card-content {
    padding: 1.5rem;
  }

  .card h2 {
    margin: 0 0 1rem 0;
    font-size: 1.5rem;
    color: #333;
  }

  .btn {
    display: inline-block;
    padding: 0.5rem 1rem;
    background: #ff3e00;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: background 0.3s ease;
  }

  .btn:hover {
    background: #ff8700;
  }

  .loading {
    text-align: center;
    padding: 2rem;
    font-size: 1.2rem;
    color: #666;
  }

  .error {
    text-align: center;
    padding: 2rem;
    color: #ff3e00;
    font-size: 1.2rem;
  }

  @media (max-width: 768px) {
    .hero {
      padding: 2rem 0;
    }

    .hero h1 {
      font-size: 2rem;
    }

    .grid {
      grid-template-columns: 1fr;
    }
  }
</style>
