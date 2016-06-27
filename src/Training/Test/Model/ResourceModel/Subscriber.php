<?php
namespace Training\Test\Model\ResourceModel;
use Magento\Framework\Model\ResourceModel\Db\AbstractDb;

class Subscriber extends AbstractDb
{
    protected function _construct()
    {
        $this->_init('training_subscribers', 'entity_id');
    }
}
