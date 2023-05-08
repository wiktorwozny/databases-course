﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using WiktorWoznyEPProducts;

#nullable disable

namespace WiktorWoznyEPProducts.Migrations
{
    [DbContext(typeof(ProductContext))]
    [Migration("20230422135623_CustomerDiscountChange")]
    partial class CustomerDiscountChange
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "7.0.5");

            modelBuilder.Entity("InvoiceProduct", b =>
                {
                    b.Property<int>("InvoicesInvoiceNumber")
                        .HasColumnType("INTEGER");

                    b.Property<int>("ProductsProductID")
                        .HasColumnType("INTEGER");

                    b.HasKey("InvoicesInvoiceNumber", "ProductsProductID");

                    b.HasIndex("ProductsProductID");

                    b.ToTable("InvoiceProduct");
                });

            modelBuilder.Entity("WiktorWoznyEPProducts.Company", b =>
                {
                    b.Property<int>("CompanyID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("City")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("CompanyName")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("Discriminator")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("Street")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("CompanyID");

                    b.ToTable("Companies");

                    b.HasDiscriminator<string>("Discriminator").HasValue("Company");

                    b.UseTphMappingStrategy();
                });

            modelBuilder.Entity("WiktorWoznyEPProducts.Invoice", b =>
                {
                    b.Property<int>("InvoiceNumber")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<int>("Quantity")
                        .HasColumnType("INTEGER");

                    b.HasKey("InvoiceNumber");

                    b.ToTable("Invoices");
                });

            modelBuilder.Entity("WiktorWoznyEPProducts.Product", b =>
                {
                    b.Property<int>("ProductID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("ProductName")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int?>("SupplierCompanyID")
                        .HasColumnType("INTEGER");

                    b.Property<int>("UnitsOnStock")
                        .HasColumnType("INTEGER");

                    b.HasKey("ProductID");

                    b.HasIndex("SupplierCompanyID");

                    b.ToTable("Products");
                });

            modelBuilder.Entity("WiktorWoznyEPProducts.Customer", b =>
                {
                    b.HasBaseType("WiktorWoznyEPProducts.Company");

                    b.Property<double>("Discount")
                        .HasColumnType("REAL");

                    b.HasDiscriminator().HasValue("Customer");
                });

            modelBuilder.Entity("WiktorWoznyEPProducts.Supplier", b =>
                {
                    b.HasBaseType("WiktorWoznyEPProducts.Company");

                    b.Property<int>("BankAccountNumber")
                        .HasColumnType("INTEGER");

                    b.HasDiscriminator().HasValue("Supplier");
                });

            modelBuilder.Entity("InvoiceProduct", b =>
                {
                    b.HasOne("WiktorWoznyEPProducts.Invoice", null)
                        .WithMany()
                        .HasForeignKey("InvoicesInvoiceNumber")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("WiktorWoznyEPProducts.Product", null)
                        .WithMany()
                        .HasForeignKey("ProductsProductID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("WiktorWoznyEPProducts.Product", b =>
                {
                    b.HasOne("WiktorWoznyEPProducts.Supplier", "Supplier")
                        .WithMany("Products")
                        .HasForeignKey("SupplierCompanyID");

                    b.Navigation("Supplier");
                });

            modelBuilder.Entity("WiktorWoznyEPProducts.Supplier", b =>
                {
                    b.Navigation("Products");
                });
#pragma warning restore 612, 618
        }
    }
}
