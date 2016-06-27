<?php
namespace Training\Test\Model;
use Magento\Framework\Model\AbstractModel;

class Subscriber extends AbstractModel
{
    protected function _construct()
    {
        $this->_init('Training\Test\Model\ResourceModel\Subscriber');
    }
}
