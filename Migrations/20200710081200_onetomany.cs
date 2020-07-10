using Microsoft.EntityFrameworkCore.Migrations;

namespace taskmanager.Migrations
{
    public partial class onetomany : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UserWorks");

            migrationBuilder.AddColumn<int>(
                name: "UserId",
                table: "Work",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Work_UserId",
                table: "Work",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Work_User_UserId",
                table: "Work",
                column: "UserId",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Work_User_UserId",
                table: "Work");

            migrationBuilder.DropIndex(
                name: "IX_Work_UserId",
                table: "Work");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Work");

            migrationBuilder.CreateTable(
                name: "UserWorks",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    WorkId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserWorks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserWorks_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserWorks_Work_WorkId",
                        column: x => x.WorkId,
                        principalTable: "Work",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserWorks_UserId",
                table: "UserWorks",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserWorks_WorkId",
                table: "UserWorks",
                column: "WorkId");
        }
    }
}
