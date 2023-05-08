using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WiktorWoznyEPProducts.Migrations
{
    /// <inheritdoc />
    public partial class InheritanceAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Suppliers",
                table: "Suppliers");

            migrationBuilder.RenameTable(
                name: "Suppliers",
                newName: "Companies");

            migrationBuilder.AddColumn<int>(
                name: "BankAccountNumber",
                table: "Companies",
                type: "INTEGER",
                nullable: true);

            migrationBuilder.AddColumn<float>(
                name: "Discount",
                table: "Companies",
                type: "REAL",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "Companies",
                type: "TEXT",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Companies",
                table: "Companies",
                column: "CompanyID");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Companies_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID",
                principalTable: "Companies",
                principalColumn: "CompanyID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Companies_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Companies",
                table: "Companies");

            migrationBuilder.DropColumn(
                name: "BankAccountNumber",
                table: "Companies");

            migrationBuilder.DropColumn(
                name: "Discount",
                table: "Companies");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "Companies");

            migrationBuilder.RenameTable(
                name: "Companies",
                newName: "Suppliers");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Suppliers",
                table: "Suppliers",
                column: "CompanyID");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Suppliers_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID",
                principalTable: "Suppliers",
                principalColumn: "CompanyID");
        }
    }
}
