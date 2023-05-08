using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WiktorWoznyEPProducts.Migrations
{
    /// <inheritdoc />
    public partial class ChangeRelation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "SupplierCompanyID",
                table: "Products");

            migrationBuilder.AddColumn<int>(
                name: "SupplierID",
                table: "Products",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Products_SupplierID",
                table: "Products",
                column: "SupplierID");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Suppliers_SupplierID",
                table: "Products",
                column: "SupplierID",
                principalTable: "Suppliers",
                principalColumn: "CompanyID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_SupplierID",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_SupplierID",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "SupplierID",
                table: "Products");

            migrationBuilder.AddColumn<int>(
                name: "SupplierCompanyID",
                table: "Products",
                type: "INTEGER",
                nullable: true);

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
    }
}
