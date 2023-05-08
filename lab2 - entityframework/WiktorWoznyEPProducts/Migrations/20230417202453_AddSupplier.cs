using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WiktorWoznyEPProducts.Migrations
{
    /// <inheritdoc />
    public partial class AddSupplier : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "SupplierCompanyID",
                table: "Products",
                type: "INTEGER",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Suppliers",
                columns: table => new
                {
                    CompanyID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    CompanyName = table.Column<string>(type: "TEXT", nullable: false),
                    Street = table.Column<string>(type: "TEXT", nullable: false),
                    City = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Suppliers", x => x.CompanyID);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Products_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Suppliers_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID",
                principalTable: "Suppliers",
                principalColumn: "CompanyID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropTable(
                name: "Suppliers");

            migrationBuilder.DropIndex(
                name: "IX_Products_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "SupplierCompanyID",
                table: "Products");
        }
    }
}
