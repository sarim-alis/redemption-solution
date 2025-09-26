-- CreateTable
CREATE TABLE "public"."Session" (
    "id" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "scope" TEXT,
    "expires" TIMESTAMP(3),
    "accessToken" TEXT NOT NULL,
    "userId" BIGINT,
    "firstName" TEXT,
    "lastName" TEXT,
    "email" TEXT,
    "accountOwner" BOOLEAN NOT NULL DEFAULT false,
    "locale" TEXT,
    "collaborator" BOOLEAN DEFAULT false,
    "emailVerified" BOOLEAN DEFAULT false,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Voucher" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "shopifyOrderId" TEXT NOT NULL,
    "customerEmail" TEXT NOT NULL,
    "productTitle" TEXT,
    "type" TEXT,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "emailSent" BOOLEAN NOT NULL DEFAULT false,
    "username" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "locationUsed" TEXT[],
    "redeemedAt" TIMESTAMP(3)[],
    "statusUse" BOOLEAN NOT NULL DEFAULT false,
    "status" TEXT,
    "expire" TIMESTAMP(3),
    "totalPrice" DOUBLE PRECISION,
    "remainingBalance" DOUBLE PRECISION,
    "cashHistory" DOUBLE PRECISION[] DEFAULT ARRAY[]::DOUBLE PRECISION[],
    "currency" TEXT,
    "afterExpiredPrice" DOUBLE PRECISION,

    CONSTRAINT "Voucher_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Product" (
    "id" TEXT NOT NULL,
    "shopifyId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "vendor" TEXT,
    "status" TEXT NOT NULL,
    "imageUrl" TEXT,
    "imageAlt" TEXT,
    "totalInventory" INTEGER NOT NULL,
    "categoryId" TEXT,
    "categoryName" TEXT,
    "type" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expire" INTEGER,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Order" (
    "id" TEXT NOT NULL,
    "shopifyOrderId" TEXT NOT NULL,
    "customerEmail" TEXT,
    "customerName" TEXT,
    "totalPrice" DOUBLE PRECISION NOT NULL,
    "remainingBalance" DOUBLE PRECISION,
    "cashHistory" DOUBLE PRECISION[] DEFAULT ARRAY[]::DOUBLE PRECISION[],
    "currency" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "fulfillmentStatus" TEXT,
    "itemQuantity" INTEGER NOT NULL,
    "processedAt" TIMESTAMP(3) NOT NULL,
    "lineItems" JSONB,
    "billingAddress" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "customerId" TEXT,
    "locationUsed" TEXT[],
    "redeemedAt" TIMESTAMP(3)[],
    "statusUse" BOOLEAN NOT NULL DEFAULT false,
    "username" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Location" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "market" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Employee" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT,
    "password" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "locationId" TEXT NOT NULL,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Customer" (
    "id" TEXT NOT NULL,
    "shopifyId" TEXT,
    "firstName" TEXT,
    "lastName" TEXT,
    "email" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "password" TEXT,
    "role" TEXT,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Voucher_code_key" ON "public"."Voucher"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Product_shopifyId_key" ON "public"."Product"("shopifyId");

-- CreateIndex
CREATE UNIQUE INDEX "Order_shopifyOrderId_key" ON "public"."Order"("shopifyOrderId");

-- CreateIndex
CREATE UNIQUE INDEX "Location_name_key" ON "public"."Location"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_username_key" ON "public"."Employee"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_email_key" ON "public"."Employee"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_shopifyId_key" ON "public"."Customer"("shopifyId");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_email_key" ON "public"."Customer"("email");

-- AddForeignKey
ALTER TABLE "public"."Voucher" ADD CONSTRAINT "Voucher_shopifyOrderId_fkey" FOREIGN KEY ("shopifyOrderId") REFERENCES "public"."Order"("shopifyOrderId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Order" ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "public"."Customer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Employee" ADD CONSTRAINT "Employee_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "public"."Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
