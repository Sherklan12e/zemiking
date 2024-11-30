<script>
  import { onMount } from 'svelte';
  import gloglo from '../images/gloglo.png';

  let items = [];
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      const response = await fetch('http://localhost:3000/');
      items = await response.json();
    } catch (e) {
      error = 'Error al cargar los datos';
    } finally {
      loading = false;
    }
  });
</script>

<div class="home-container">
  {#if loading}
    <div class="loading">Cargando contenido...</div>
  {:else if error}
    <div class="error">{error}</div>
  {:else}
    <div class="content-layout">
      <!-- Cards izquierdas -->
      <div class="cards-left">
        {#each items.slice(0, 2) as item}
          <div class="card">
            {#if item.image_url}
              <img src={`http://localhost:3000/${item.image_url}`} alt={item.name} />
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

      <!-- Imagen central -->
      <div class="center-image">
        <img src={gloglo} alt="Gloglo" class="gloglo-image" />
      </div>

      <!-- Cards derechas -->
      <div class="cards-right">
        {#each items.slice(2, 4) as item}
          <div class="card">
            {#if item.image_url}
              <img src={`http://localhost:3000/${item.image_url}`} alt={item.title} />
              {console.log(`http://localhost:3000/${item.image_url}`)}
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
    </div>
  {/if}
</div>

<style>
  .home-container {
    width: 100%;
    max-width: 1400px;
    margin: 0 auto;
    padding: 2rem;
  }

  .content-layout {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    gap: 2rem;
    align-items: center;
  }

  .center-image {
    padding: 2rem;
  }

  .gloglo-image {
    width: 500px;
    height: 700px;
    object-fit: contain;
  }

  .cards-left, .cards-right {
    display: flex;
    flex-direction: column;
    gap: 2rem;
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

  @media (max-width: 1200px) {
    .content-layout {
      grid-template-columns: 1fr;
      grid-template-rows: auto auto auto;
    }

    .gloglo-image {
      width: 100%;
      max-width: 500px;
      height: auto;
      margin: 0 auto;
    }

    .cards-left, .cards-right {
      flex-direction: row;
      flex-wrap: wrap;
      justify-content: center;
    }

    .card {
      width: calc(50% - 1rem);
    }
  }

  @media (max-width: 768px) {
    .card {
      width: 100%;
    }
  }
</style>
