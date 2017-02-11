FROM debian:sid

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl fish git jq man neovim ranger sudo tig && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' ryan && \
    adduser ryan sudo

USER ryan
ENV HOME /home/ryan
WORKDIR $HOME

RUN curl -sSL http://dotfiles.rdavis.xyz | sh

COPY ./entrypoint.sh /tmp/
ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["fish"]
