# Usa la imagen base de Node.js
FROM node

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY package*.json ./
RUN npm install

COPY . .

# Expone el puerto de la aplicación
EXPOSE 3000

# Comando para iniciar la app
CMD ["npm", "start"]
