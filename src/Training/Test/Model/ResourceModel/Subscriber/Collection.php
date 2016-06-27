<?php

namespace Training\Test\Model\ResourceModel\Subscriber;
use Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection;

class Collection extends AbstractCollection
{
    protected function _construct()
    {
        $this->_init(
            'Training\Test\Model\Subscriber',
            'Training\Test\Model\ResourceModel\Subscriber'
        );
    }
}