<?php
namespace Training\Test\Model\Plugin;

class AddHalfPricePlugin
{
    public function afterGetPrice(
        \Magento\Catalog\Api\Data\ProductInterface $subject,
        $price
    ) {
        return $price * 1.5;
    }
}
