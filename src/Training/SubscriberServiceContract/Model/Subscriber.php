<?php
namespace Training\SubscriberServiceContract\Model;
use Magento\Framework\Model\AbstractModel;
use Training\SubscriberServiceContract\Api\Data\SubscriberInterface;

class Subscriber extends AbstractModel implements SubscriberInterface
{
    protected function _construct()
    {
        $this->_init('Training\SubscriberServiceContract\Model\ResourceModel\Subscriber');
    }

    public function getId()
    {
        return $this->getData('entity_id');
    }

    public function getName()
    {
        return $this->getData('name');
    }

    public function getEmail()
    {
        return $this->getData('email');
    }

    public function getComment()
    {
        return $this->getData('comment');
    }

    public function getCreatedAt()
    {
        return $this->getData('created_at');
    }

    public function getUpdatedAt()
    {
        return $this->getData('updated_at');
    }

    public function setName($name)
    {
        $this->setData('name', $name);
    }

    public function setEmail($email)
    {
        $this->setData('email', $email);
    }

    public function setComment($comment)
    {
        $this->setData('comment', $comment);
    }
}
