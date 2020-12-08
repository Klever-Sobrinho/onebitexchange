FROM ruby:2.5.1
 
# add nodejs and yarn dependencies for the frontend
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
 
# Instala nossas dependencias
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
nodejs yarn build-essential libpq-dev imagemagick git-all nano
 
 
# Seta o path como o diretório principal
WORKDIR /onebitexchange

# Copia o Gemfile para dentro do container
COPY Gemfile /onebitexchange/Gemfile

# Copia o Gemfile.lock para dentro do container
COPY Gemfile /onebitexchange/Gemfile.lock

# Roda o bundle para instalar as dependências
RUN bundle install

# Copia nosso código para dentro do container
COPY . /onebitexchange

# Add um script para ser executado sempre que o container iniciar.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Inicia o processo principal.
CMD ["rails", "server", "-b", "0.0.0.0"]
 
