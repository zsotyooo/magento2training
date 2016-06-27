<?php

namespace Training\SubscriberServiceContract\Model\ResourceModel\Subscriber;
use Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection;

class Collection extends AbstractCollection
{
    protected function _construct()
    {
        $this->_init(
            'Training\SubscriberServiceContract\Model\Subscriber',
            'Training\SubscriberServiceContract\Model\ResourceModel\Subscriber'
        );
    }
}