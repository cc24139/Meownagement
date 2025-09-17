using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace APIMeow.Migrations
{
    /// <inheritdoc />
    public partial class Inicial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "Meownagement");

            migrationBuilder.CreateTable(
                name: "Classificacao",
                schema: "Meownagement",
                columns: table => new
                {
                    IdClassificacao = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Tipo = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Classificacao", x => x.IdClassificacao);
                });

            migrationBuilder.CreateTable(
                name: "Gatos",
                schema: "Meownagement",
                columns: table => new
                {
                    IdGato = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Nome = table.Column<string>(type: "text", nullable: false),
                    Raridade = table.Column<int>(type: "integer", nullable: false),
                    CodPaleta = table.Column<int>(type: "integer", nullable: false),
                    NomeImagem = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Gatos", x => x.IdGato);
                });

            migrationBuilder.CreateTable(
                name: "Recorrencia",
                schema: "Meownagement",
                columns: table => new
                {
                    IdRecorrencia = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    QtsDias = table.Column<int>(type: "integer", nullable: false),
                    QtsMeses = table.Column<int>(type: "integer", nullable: false),
                    QtsAnos = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recorrencia", x => x.IdRecorrencia);
                });

            migrationBuilder.CreateTable(
                name: "Usuario",
                schema: "Meownagement",
                columns: table => new
                {
                    IdUsuario = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Senha = table.Column<string>(type: "text", nullable: false),
                    Biografia = table.Column<string>(type: "text", nullable: false),
                    Nome = table.Column<string>(type: "text", nullable: false),
                    Email = table.Column<string>(type: "text", nullable: false),
                    Saldo = table.Column<decimal>(type: "numeric", nullable: false),
                    Pontos = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usuario", x => x.IdUsuario);
                });

            migrationBuilder.CreateTable(
                name: "Cofrinho",
                schema: "Meownagement",
                columns: table => new
                {
                    IdCofrinho = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Economia = table.Column<decimal>(type: "numeric", nullable: false),
                    QtsMoedas = table.Column<int>(type: "integer", nullable: false),
                    DinheiroEconomizado = table.Column<decimal>(type: "numeric", nullable: false),
                    DataCriacao = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    DataTermino = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Feita = table.Column<char>(type: "character(1)", nullable: false),
                    Nome = table.Column<string>(type: "text", nullable: false),
                    IdUsuario = table.Column<int>(type: "integer", nullable: false),
                    IdClassificacao = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cofrinho", x => x.IdCofrinho);
                    table.ForeignKey(
                        name: "FK_Cofrinho_Classificacao_IdClassificacao",
                        column: x => x.IdClassificacao,
                        principalSchema: "Meownagement",
                        principalTable: "Classificacao",
                        principalColumn: "IdClassificacao",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Cofrinho_Usuario_IdUsuario",
                        column: x => x.IdUsuario,
                        principalSchema: "Meownagement",
                        principalTable: "Usuario",
                        principalColumn: "IdUsuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LoginDiario",
                schema: "Meownagement",
                columns: table => new
                {
                    IdUsuario = table.Column<int>(type: "integer", nullable: false),
                    IdLogin = table.Column<int>(type: "integer", nullable: false),
                    NumSequencia = table.Column<int>(type: "integer", nullable: false),
                    UltimoLogin = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LoginDiario", x => x.IdUsuario);
                    table.ForeignKey(
                        name: "FK_LoginDiario_Usuario_IdUsuario",
                        column: x => x.IdUsuario,
                        principalSchema: "Meownagement",
                        principalTable: "Usuario",
                        principalColumn: "IdUsuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Metas",
                schema: "Meownagement",
                columns: table => new
                {
                    IdMeta = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Nome = table.Column<string>(type: "text", nullable: false),
                    GastoLimite = table.Column<decimal>(type: "numeric", nullable: false),
                    QtsMoedas = table.Column<int>(type: "integer", nullable: false),
                    DataCriacao = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    DataTermino = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Feita = table.Column<char>(type: "character(1)", nullable: false),
                    IdUsuario = table.Column<int>(type: "integer", nullable: false),
                    IdClassificacao = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Metas", x => x.IdMeta);
                    table.ForeignKey(
                        name: "FK_Metas_Classificacao_IdClassificacao",
                        column: x => x.IdClassificacao,
                        principalSchema: "Meownagement",
                        principalTable: "Classificacao",
                        principalColumn: "IdClassificacao",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Metas_Usuario_IdUsuario",
                        column: x => x.IdUsuario,
                        principalSchema: "Meownagement",
                        principalTable: "Usuario",
                        principalColumn: "IdUsuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Post",
                schema: "Meownagement",
                columns: table => new
                {
                    IdPost = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Titulo = table.Column<string>(type: "text", nullable: false),
                    Conteudo = table.Column<string>(type: "text", nullable: false),
                    Data = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Likes = table.Column<int>(type: "integer", nullable: false),
                    Deslikes = table.Column<int>(type: "integer", nullable: false),
                    IdUsuario = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Post", x => x.IdPost);
                    table.ForeignKey(
                        name: "FK_Post_Usuario_IdUsuario",
                        column: x => x.IdUsuario,
                        principalSchema: "Meownagement",
                        principalTable: "Usuario",
                        principalColumn: "IdUsuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Transacao",
                schema: "Meownagement",
                columns: table => new
                {
                    IdTransacao = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Nome = table.Column<string>(type: "text", nullable: false),
                    QuantiaDinheiro = table.Column<decimal>(type: "numeric", nullable: false),
                    DataCriacao = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Feita = table.Column<char>(type: "character(1)", nullable: false),
                    DataFinalizacao = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    SaldoAtual = table.Column<decimal>(type: "numeric", nullable: false),
                    IdUsuario = table.Column<int>(type: "integer", nullable: false),
                    IdClassificacao = table.Column<int>(type: "integer", nullable: false),
                    IdRecorrencia = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Transacao", x => x.IdTransacao);
                    table.ForeignKey(
                        name: "FK_Transacao_Classificacao_IdClassificacao",
                        column: x => x.IdClassificacao,
                        principalSchema: "Meownagement",
                        principalTable: "Classificacao",
                        principalColumn: "IdClassificacao",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Transacao_Recorrencia_IdRecorrencia",
                        column: x => x.IdRecorrencia,
                        principalSchema: "Meownagement",
                        principalTable: "Recorrencia",
                        principalColumn: "IdRecorrencia");
                    table.ForeignKey(
                        name: "FK_Transacao_Usuario_IdUsuario",
                        column: x => x.IdUsuario,
                        principalSchema: "Meownagement",
                        principalTable: "Usuario",
                        principalColumn: "IdUsuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UsuarioGato",
                schema: "Meownagement",
                columns: table => new
                {
                    IdUsuario = table.Column<int>(type: "integer", nullable: false),
                    IdGato = table.Column<int>(type: "integer", nullable: false),
                    Copias = table.Column<int>(type: "integer", nullable: false),
                    Equipado = table.Column<char>(type: "character(1)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UsuarioGato", x => new { x.IdUsuario, x.IdGato });
                    table.ForeignKey(
                        name: "FK_UsuarioGato_Gatos_IdGato",
                        column: x => x.IdGato,
                        principalSchema: "Meownagement",
                        principalTable: "Gatos",
                        principalColumn: "IdGato",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UsuarioGato_Usuario_IdUsuario",
                        column: x => x.IdUsuario,
                        principalSchema: "Meownagement",
                        principalTable: "Usuario",
                        principalColumn: "IdUsuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Comentario",
                schema: "Meownagement",
                columns: table => new
                {
                    IdComentario = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Titulo = table.Column<string>(type: "text", nullable: false),
                    Conteudo = table.Column<string>(type: "text", nullable: false),
                    Data = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Likes = table.Column<int>(type: "integer", nullable: false),
                    Deslikes = table.Column<int>(type: "integer", nullable: false),
                    IdUsuario = table.Column<int>(type: "integer", nullable: false),
                    IdPost = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comentario", x => x.IdComentario);
                    table.ForeignKey(
                        name: "FK_Comentario_Post_IdPost",
                        column: x => x.IdPost,
                        principalSchema: "Meownagement",
                        principalTable: "Post",
                        principalColumn: "IdPost",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Comentario_Usuario_IdUsuario",
                        column: x => x.IdUsuario,
                        principalSchema: "Meownagement",
                        principalTable: "Usuario",
                        principalColumn: "IdUsuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "MetaCofrinhoTransacao",
                schema: "Meownagement",
                columns: table => new
                {
                    IdRel = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    IdMeta = table.Column<int>(type: "integer", nullable: true),
                    IdCofrinho = table.Column<int>(type: "integer", nullable: true),
                    IdTransacao = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MetaCofrinhoTransacao", x => x.IdRel);
                    table.ForeignKey(
                        name: "FK_MetaCofrinhoTransacao_Transacao_IdTransacao",
                        column: x => x.IdTransacao,
                        principalSchema: "Meownagement",
                        principalTable: "Transacao",
                        principalColumn: "IdTransacao",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Cofrinho_IdClassificacao",
                schema: "Meownagement",
                table: "Cofrinho",
                column: "IdClassificacao");

            migrationBuilder.CreateIndex(
                name: "IX_Cofrinho_IdUsuario",
                schema: "Meownagement",
                table: "Cofrinho",
                column: "IdUsuario");

            migrationBuilder.CreateIndex(
                name: "IX_Comentario_IdPost",
                schema: "Meownagement",
                table: "Comentario",
                column: "IdPost");

            migrationBuilder.CreateIndex(
                name: "IX_Comentario_IdUsuario",
                schema: "Meownagement",
                table: "Comentario",
                column: "IdUsuario");

            migrationBuilder.CreateIndex(
                name: "IX_MetaCofrinhoTransacao_IdTransacao",
                schema: "Meownagement",
                table: "MetaCofrinhoTransacao",
                column: "IdTransacao");

            migrationBuilder.CreateIndex(
                name: "IX_Metas_IdClassificacao",
                schema: "Meownagement",
                table: "Metas",
                column: "IdClassificacao");

            migrationBuilder.CreateIndex(
                name: "IX_Metas_IdUsuario",
                schema: "Meownagement",
                table: "Metas",
                column: "IdUsuario");

            migrationBuilder.CreateIndex(
                name: "IX_Post_IdUsuario",
                schema: "Meownagement",
                table: "Post",
                column: "IdUsuario");

            migrationBuilder.CreateIndex(
                name: "IX_Transacao_IdClassificacao",
                schema: "Meownagement",
                table: "Transacao",
                column: "IdClassificacao");

            migrationBuilder.CreateIndex(
                name: "IX_Transacao_IdRecorrencia",
                schema: "Meownagement",
                table: "Transacao",
                column: "IdRecorrencia");

            migrationBuilder.CreateIndex(
                name: "IX_Transacao_IdUsuario",
                schema: "Meownagement",
                table: "Transacao",
                column: "IdUsuario");

            migrationBuilder.CreateIndex(
                name: "IX_UsuarioGato_IdGato",
                schema: "Meownagement",
                table: "UsuarioGato",
                column: "IdGato");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Cofrinho",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Comentario",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "LoginDiario",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "MetaCofrinhoTransacao",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Metas",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "UsuarioGato",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Post",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Transacao",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Gatos",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Classificacao",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Recorrencia",
                schema: "Meownagement");

            migrationBuilder.DropTable(
                name: "Usuario",
                schema: "Meownagement");
        }
    }
}
