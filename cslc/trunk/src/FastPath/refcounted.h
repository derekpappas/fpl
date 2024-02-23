#ifndef REFCOUNTED_H
#define REFCOUNTED_H

class RefCounted
{
public:
    RefCounted() : counter(0)
    {
    }
    virtual ~RefCounted()
    {
    }
    virtual int reference()
    {
        counter++;
        return counter;
    }
    virtual int release()
    {
        counter--;
        if (counter <= 0)
        {
            delete this;
            return 0;
        }
        else
            return counter;
    }
protected:
    RefCounted(const RefCounted&)
    {
    }
    RefCounted& operator= (const RefCounted&)
    {
        return *this;
    }
    int counter;
};

template <class T> class RefCounting
{
private:
    T* t;
public:
    RefCounting(T* t_= 0) : t(t_)
    {
        if (t)
            t->reference();
    }
    RefCounting(const RefCounting& r_) : t(r_.t)
    {
        if (t)
            t->reference();
    }
    RefCounting& operator=(const RefCounting& r_)
    {
        if (t)
            t->release();
        t = r_.t;
        if (t)
            t->reference();
        return *this;
    }
    ~RefCounting()
    {
        if (t)
            t->release();
        t = (T*) 0;
    }
    inline T* operator->() const
    {
        return t;
    }
    inline T& operator*() const
    {
        return *t;
    }
    inline T* get() const
    {
        return t;
    }
    inline void set(T* t_)
    {
        if (t)
            t->release();
        t = t_;
        if (t)
            t->reference();
    }
    inline bool operator==(const RefCounting& r_) const
    {
        return t == r_.t;
    }
    inline bool operator!=(const RefCounting& r_) const
    {
        return t != r_.t;
    }
};

template <class T>
class RefCountingCompare
{
public:
    bool operator()(const RefCounting<T>& l, const RefCounting<T>& r) const
    {
        return (l.get() < r.get());
    }
};


#endif // REFCOUNTED_H
