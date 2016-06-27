<?php

namespace Training\SubscriberManagement\Controller\Subscriber;

use Magento\Framework\App\Action\Action;
use Magento\Framework\App\Action\Context;
use Training\SubscriberServiceContract\Model\SubscriberRepositoryFactory;
use Magento\Customer\Api\CustomerRepositoryInterface;
use Magento\Framework\Api\SearchCriteriaBuilder;
use Magento\Framework\Api\SortOrderBuilder;
use Magento\Framework\Api\FilterBuilder;
use Magento\Framework\Controller\Result\Json as JsonResult;
use Magento\Framework\Controller\Result\JsonFactory;
use Magento\Framework\Json\Helper\Data as JsonHelper;

abstract class AbstractSubscriberAction extends Action
{
    protected $logger;

    protected $subscriberRepositoryFactory;

    protected $customerRepository;

    protected $jsonResponse;

    protected $jsonHelper;

    protected $searchCriteriaBuilder;

    protected $sortOrderBuilder;

    protected $filterBuilder;
    
    public function __construct(
        Context $context,
        \Psr\Log\LoggerInterface $logger,
        SubscriberRepositoryFactory $subscriberRepositoryFactory,
        CustomerRepositoryInterface $customerRepository,
        SearchCriteriaBuilder $searchCriteriaBuilder,
        SortOrderBuilder $sortOrderBuilder,
        FilterBuilder $filterBuilder,
        JsonHelper $jsonHelper,
        JsonFactory $jsonResponse
    ) {
        parent::__construct($context);
        $this->logger = $logger;
        $this->subscriberRepositoryFactory = $subscriberRepositoryFactory;
        $this->searchCriteriaBuilder = $searchCriteriaBuilder;
        $this->sortOrderBuilder = $sortOrderBuilder;
        $this->filterBuilder = $filterBuilder;
        $this->jsonResponse = $jsonResponse;
        $this->jsonHelper = $jsonHelper;
        $this->customerRepository = $customerRepository;
    }
}
