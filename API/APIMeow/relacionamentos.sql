-- Arquivo de relacionamentos e chaves estrangeiras

ALTER TABLE Metas
ADD CONSTRAINT FK_Metas_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
ADD CONSTRAINT FK_Metas_Classificacao FOREIGN KEY (IdClassificacao) REFERENCES Classificacao(IdClassificacao);

ALTER TABLE Cofrinho
ADD CONSTRAINT FK_Cofrinho_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
ADD CONSTRAINT FK_Cofrinho_Classificacao FOREIGN KEY (IdClassificacao) REFERENCES Classificacao(IdClassificacao);

ALTER TABLE Transacao
ADD CONSTRAINT FK_Transacao_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
ADD CONSTRAINT FK_Transacao_Classificacao FOREIGN KEY (IdClassificacao) REFERENCES Classificacao(IdClassificacao),
ADD CONSTRAINT FK_Transacao_Recorrencia FOREIGN KEY (IdRecorrencia) REFERENCES Recorrencia(IdRecorrencia);

ALTER TABLE UsuarioGato
ADD CONSTRAINT FK_UsuarioGato_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
ADD CONSTRAINT FK_UsuarioGato_Gatos FOREIGN KEY (IdGato) REFERENCES Gatos(IdGato);
