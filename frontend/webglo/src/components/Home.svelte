<script>
  import { onMount } from 'svelte';

  let items = [];
  let newItem = {
    title: '',
    image: null,
    link: ''
  };
  let error = '';

  onMount(async () => {
    await loadItems();
  });

  async function loadItems() {
    try {
      const response = await fetch('http://localhost:8000/api/content/', {
        credentials: 'include'
      });
      if (response.ok) {
        items = await response.json();
      }
    } catch (e) {
      error = 'Error al cargar los items';
    }
  }

  async function handleSubmit() {
    const formData = new FormData();
    formData.append('title', newItem.title);
    if (newItem.image) {
      formData.append('image', newItem.image);
    }
    if (newItem.link) {
      formData.append('link', newItem.link);
    }

    try {
      const response = await fetch('http://localhost:8000/api/content/', {
        method: 'POST',
        credentials: 'include',
        body: formData
      });

      if (response.ok) {
        await loadItems();
        newItem = { title: '', image: null, link: '' };
      } else {
        error = 'Error al crear el item';
      }
    } catch (e) {
      error = 'Error de conexión';
    }
  }

  function handleImageChange(event) {
    newItem.image = event.target.files[0];
  }
</script>

<div class="home-container">
  <h2>Panel de Administración</h2>

  {#if error}
    <div class="error">{error}</div>
  {/if}

  <form on:submit|preventDefault={handleSubmit} class="add-form">
    <h3>Agregar Nuevo Item</h3>
    
    <div class="form-group">
      <label for="title">Título:</label>
      <input
        type="text"
        id="title"
        bind:value={newItem.title}
        required
      />
    </div>

    <div class="form-group">
      <label for="image">Imagen:</label>
      <input
        type="file"
        id="image"
        accept="image/*"
        on:change={handleImageChange}
      />
    </div>

    <div class="form-group">
      <label for="link">Enlace:</label>
      <input
        type="url"
        id="link"
        bind:value={newItem.link}
      />
    </div>

    <button type="submit">Agregar Item</button>
  </form>

  <div class="items-list">
    <h3>Items Existentes</h3>
    {#each items as item}
      <div class="item-card">
        <h4>{item.title}</h4>
        {#if item.image}
          <img src={`http://localhost:8000${item.image}`} alt={item.title} />
        {/if}
        {#if item.link}
          <a href={item.link} target="_blank">Ver enlace</a>
        {/if}
        <p>Creado: {new Date(item.created_at).toLocaleDateString()}</p>
      </div>
    {/each}
  </div>
</div>

<style>
  .home-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem;
  }

  .add-form {
    margin-bottom: 2rem;
    padding: 1rem;
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
    padding: 0.75rem;
    background: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .items-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 1rem;
  }

  .item-card {
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 8px;
  }

  .item-card img {
    max-width: 100%;
    height: auto;
  }

  .error {
    color: red;
    margin-bottom: 1rem;
  }
</style>
