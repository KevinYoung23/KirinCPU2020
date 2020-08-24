using namespace std;

struct node {
	int value;
	node* pointer;
};

node* find(const int x, node* head) {
	while (head->value != x) {
		head = head->pointer;
		if (head->pointer == nullptr) {
			break;
		}
	}
	return head;
}