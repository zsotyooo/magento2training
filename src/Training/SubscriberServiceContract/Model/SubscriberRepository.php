<?php

namespace Training\SubscriberServiceContract\Model;

use Magento\Framework\Api\SearchCriteria;
use Training\SubscriberServiceContract\Api\Data\SubscriberInterface;
use Training\SubscriberServiceContract\Api\SubscriberRepositoryInterface;
use Training\SubscriberServiceContract\Model\SubscriberFactory;
use Training\SubscriberServiceContract\Model\ResourceModel\Subscriber\CollectionFactory as SubscriberCollectionFactory;
use Magento\Framework\Api\SearchResultsInterfaceFactory as SearchResultsFactory;
use Magento\Framework\Api\SearchResultsInterface;
use Magento\Framework\Api\SortOrder;

class SubscriberRepository implements SubscriberRepositoryInterface
{

    private $subscribersById;

    private $subscriberFactory;

    private $subscriberCollectionFactory;

    private $searchResultsFactory;

    public function __construct(
        SubscriberFactory $subscriberFactory,
        SubscriberCollectionFactory $subscriberCollectionFactory,
        SearchResultsFactory $searchResultsInterface
    ) {
        $this->subscriberFactory = $subscriberFactory;
        $this->subscriberCollectionFactory = $subscriberCollectionFactory;
        $this->searchResultsFactory = $searchResultsInterface;
    }

    public function get($subscriberId)
    {
        if (!isset($this->subscribersById[$subscriberId])) {
            $subscriber = $this->subscriberFactory->create();
            $subscriber->load($subscriberId);
            $this->subscribersById[$subscriberId] = $subscriber;
        }
        return $this->subscribersById[$subscriberId];
    }

    public function getList(SearchCriteria $criteria)
    {
        $searchResults = $this->searchResultsFactory->create();
        $searchResults->setSearchCriteria($criteria);  
        $collection = $this->subscriberCollectionFactory->create();
        foreach ($criteria->getFilterGroups() as $filterGroup) {
            $fields = [];
            $conditions = [];
            foreach ($filterGroup->getFilters() as $filter) {
                $condition = $filter->getConditionType() ? $filter->getConditionType() : 'eq';
                $fields[] = $filter->getField();
                $conditions[] = [$condition => $filter->getValue()];
            }
            if ($fields) {
                $collection->addFieldToFilter($fields, $conditions);
            }
        }  
        $searchResults->setTotalCount($collection->getSize());
        $sortOrders = $criteria->getSortOrders();
        if ($sortOrders) {
            /** @var SortOrder $sortOrder */
            foreach ($sortOrders as $sortOrder) {
                $collection->addOrder(
                    $sortOrder->getField(),
                    ($sortOrder->getDirection() == SortOrder::SORT_ASC) ? 'ASC' : 'DESC'
                );
            }
        }
        $collection->setCurPage($criteria->getCurrentPage());
        $collection->setPageSize($criteria->getPageSize());
        $searchResults->setItems($collection->getItems());
        return $searchResults;        
    }

    public function save(SubscriberInterface $subscriber)
    {
        $subscriber->save();
        unset($this->subscribersById[$subscriber->getId()]);
    }

    public function delete(SubscriberInterface $subscriber)
    {
        $subscriberId = $subscriber->getId();
        $subscriber->delete();
        unset($this->subscribersById[$subscriberId]);
    }
}