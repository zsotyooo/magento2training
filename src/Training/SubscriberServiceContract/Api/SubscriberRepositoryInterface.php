<?php
namespace Training\SubscriberServiceContract\Api;

use Magento\Framework\Api\SearchCriteria;
use Training\SubscriberServiceContract\Api\Data\SubscriberInterface;

interface SubscriberRepositoryInterface
{

    public function get($subscriberId);

    public function getList(SearchCriteria $searchCriteria);

    public function save(SubscriberInterface $subscriber);

    public function delete(SubscriberInterface $subscriber);
}