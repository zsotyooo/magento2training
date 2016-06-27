<?php
namespace Training\Test\Model;

class Product extends \Magento\Catalog\Model\Product
{
    public function getPrice()
    {
        $price = parent::getPrice();
        return $price - 0.99;
    }
}
