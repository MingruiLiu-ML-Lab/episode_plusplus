import torch


def kl_div(P, Q):
    """
    Compute KL divergence between two categorical distributions. We clamp the operand of
    log in order to avoid numerical instability.
    """
    return (P * (torch.clamp(P / Q, min=1e-8)).log()).sum()


def debug(x, rank):
    with open(f"DEBUG_{rank}", "a+") as f:
        f.write(f"{rank}: {x}\n")


def get_client_label_dist(loader, num_classes):
    """
    Compute the label distribution for each client in a MultiClientLoader.
    """

    # Iterate through data of each client and compute label distribution.
    client_label_dist = []
    for r in range(loader.num_clients):
        loader.set_clients([r])
        label_dist = torch.zeros(num_classes)
        while True:
            try:
                _, labels = loader.next(cycle=False)
            except StopIteration:
                break
            for c in range(num_classes):
                label_dist[c] += torch.sum(labels == c)
        label_dist = label_dist / torch.sum(label_dist)
        client_label_dist.append(label_dist.clone())

    # Reset iterator for each client.
    for r in range(loader.num_clients):
        loader.set_clients([r])

    return torch.stack(client_label_dist)
